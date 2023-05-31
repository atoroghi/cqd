import os, sys
import subprocess


if __name__ == '__main__':

    # Save original stdout for later restoration
    original_stdout = sys.stdout

    # Open a file for writing

    cov_anchors = [1e-5,1e-4,1e-3,1e-2, 1e-1,1e1,1e2,1e3,1e4,1e5]
    cov_vars = [1e-5,1e-4,1e-3,1e-2, 1e-1,1e1,1e2,1e3,1e4,1e5]
    cov_targets = [1e-5,1e-4,1e-3,1e-2, 1e-1,1e1,1e2,1e3,1e4,1e5]


    for cov_anchor in cov_anchors:
        for cov_var in cov_vars:
            for cov_target in cov_targets:
                output_file = f"slurm_{cov_target}_{cov_anchor}.out"
                command = ["python3", "-m", "kbc.cqd_beam_bpl", "data/Movielens", "--model_path", "models/Movielens-SimplE-model-rank-50-epoch-40-1684629098.pt", "--dataset", "Movielens", "--candidates", "3", "--quantifier", "marginal_ui", "--cov_target", str(cov_target), "--cov_var", str(cov_var), "--cov_anchor", str(cov_anchor)]
                with open(output_file, "w") as f:
                    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    stdout, stderr = process.communicate()
                    f.write(stdout.decode())
                    if stderr:
                        f.write(stderr.decode())
                return_code = process.returncode
                print(f"Command returned with code {return_code} for cov_target={cov_target} and cov_anchor={cov_anchor}")